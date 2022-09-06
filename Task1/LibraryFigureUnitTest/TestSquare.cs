using LibraryFigure;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;

namespace LibraryFigureTest
{
    [TestClass]
    public class TestSquare
    {
        [TestMethod]
        public void TestRightTriangle() //Тестирование площади прямоугольного треугольника
        {
            //Вводные данные
            int a = 8;
            int b = 6;
            int c = 10;
            double expected = 24; //ожидаю получить 24

            //Создаем треугольник
            Figure figure1 = new Triangle(a, b, c, null);
            double actual = figure1.GetSquare();

            Assert.AreEqual(expected, actual);
        }
    }
}
